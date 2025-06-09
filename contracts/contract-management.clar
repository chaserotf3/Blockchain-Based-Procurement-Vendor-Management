;; Contract Management Contract
;; Manages vendor contracts and agreements

(define-map contracts
  { contract-id: uint }
  {
    vendor-id: uint,
    client: principal,
    contract-value: uint,
    start-date: uint,
    end-date: uint,
    status: (string-ascii 20),
    terms-hash: (string-ascii 64)
  }
)

(define-map contract-milestones
  { contract-id: uint, milestone-id: uint }
  {
    description: (string-ascii 200),
    due-date: uint,
    payment-amount: uint,
    completed: bool,
    completion-date: (optional uint)
  }
)

(define-data-var next-contract-id uint u1)

;; Create new contract
(define-public (create-contract
  (vendor-id uint)
  (contract-value uint)
  (start-date uint)
  (end-date uint)
  (terms-hash (string-ascii 64))
)
  (let ((contract-id (var-get next-contract-id)))
    (map-set contracts
      { contract-id: contract-id }
      {
        vendor-id: vendor-id,
        client: tx-sender,
        contract-value: contract-value,
        start-date: start-date,
        end-date: end-date,
        status: "active",
        terms-hash: terms-hash
      }
    )
    (var-set next-contract-id (+ contract-id u1))
    (ok contract-id)
  )
)

;; Add milestone to contract
(define-public (add-milestone
  (contract-id uint)
  (milestone-id uint)
  (description (string-ascii 200))
  (due-date uint)
  (payment-amount uint)
)
  (begin
    (map-set contract-milestones
      { contract-id: contract-id, milestone-id: milestone-id }
      {
        description: description,
        due-date: due-date,
        payment-amount: payment-amount,
        completed: false,
        completion-date: none
      }
    )
    (ok true)
  )
)

;; Complete milestone
(define-public (complete-milestone (contract-id uint) (milestone-id uint))
  (match (map-get? contract-milestones { contract-id: contract-id, milestone-id: milestone-id })
    milestone-data
    (begin
      (map-set contract-milestones
        { contract-id: contract-id, milestone-id: milestone-id }
        (merge milestone-data { completed: true, completion-date: (some block-height) })
      )
      (ok true)
    )
    (err u404)
  )
)

;; Update contract status
(define-public (update-contract-status (contract-id uint) (new-status (string-ascii 20)))
  (match (map-get? contracts { contract-id: contract-id })
    contract-data
    (begin
      (asserts! (is-eq tx-sender (get client contract-data)) (err u403))
      (map-set contracts
        { contract-id: contract-id }
        (merge contract-data { status: new-status })
      )
      (ok true)
    )
    (err u404)
  )
)

;; Get contract details
(define-read-only (get-contract (contract-id uint))
  (map-get? contracts { contract-id: contract-id })
)

;; Get milestone details
(define-read-only (get-milestone (contract-id uint) (milestone-id uint))
  (map-get? contract-milestones { contract-id: contract-id, milestone-id: milestone-id })
)
