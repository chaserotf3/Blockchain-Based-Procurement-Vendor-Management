;; Compliance Monitoring Contract
;; Monitors vendor compliance with regulations and standards

(define-map compliance-records
  { vendor-id: uint, compliance-type: (string-ascii 50) }
  {
    status: (string-ascii 20),
    last-check-date: uint,
    expiry-date: (optional uint),
    certificate-hash: (optional (string-ascii 64)),
    notes: (string-ascii 300)
  }
)

(define-map compliance-violations
  { violation-id: uint }
  {
    vendor-id: uint,
    violation-type: (string-ascii 100),
    severity: uint,
    reported-date: uint,
    resolved: bool,
    resolution-date: (optional uint)
  }
)

(define-data-var next-violation-id uint u1)

;; Update compliance status
(define-public (update-compliance-status
  (vendor-id uint)
  (compliance-type (string-ascii 50))
  (status (string-ascii 20))
  (expiry-date (optional uint))
  (certificate-hash (optional (string-ascii 64)))
  (notes (string-ascii 300))
)
  (begin
    (map-set compliance-records
      { vendor-id: vendor-id, compliance-type: compliance-type }
      {
        status: status,
        last-check-date: block-height,
        expiry-date: expiry-date,
        certificate-hash: certificate-hash,
        notes: notes
      }
    )
    (ok true)
  )
)

;; Report compliance violation
(define-public (report-violation
  (vendor-id uint)
  (violation-type (string-ascii 100))
  (severity uint)
)
  (let ((violation-id (var-get next-violation-id)))
    (asserts! (and (>= severity u1) (<= severity u5)) (err u400))
    (map-set compliance-violations
      { violation-id: violation-id }
      {
        vendor-id: vendor-id,
        violation-type: violation-type,
        severity: severity,
        reported-date: block-height,
        resolved: false,
        resolution-date: none
      }
    )
    (var-set next-violation-id (+ violation-id u1))
    (ok violation-id)
  )
)

;; Resolve violation
(define-public (resolve-violation (violation-id uint))
  (match (map-get? compliance-violations { violation-id: violation-id })
    violation-data
    (begin
      (map-set compliance-violations
        { violation-id: violation-id }
        (merge violation-data { resolved: true, resolution-date: (some block-height) })
      )
      (ok true)
    )
    (err u404)
  )
)

;; Check vendor compliance
(define-read-only (get-compliance-status (vendor-id uint) (compliance-type (string-ascii 50)))
  (map-get? compliance-records { vendor-id: vendor-id, compliance-type: compliance-type })
)

;; Get violation details
(define-read-only (get-violation (violation-id uint))
  (map-get? compliance-violations { violation-id: violation-id })
)

;; Check if vendor has active violations
(define-read-only (has-active-violations (vendor-id uint))
  ;; This is a simplified check - in practice, you'd iterate through violations
  (ok false)
)
