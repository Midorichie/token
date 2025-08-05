(define-constant name "Hammed Token")
(define-constant symbol "HAM")
(define-constant decimals u6)
(define-constant total-supply u1000000)

(define-map balances
  { account: principal }
  { amount: uint })

(define-public (initialize)
  (begin
    (asserts! (is-eq (get amount (map-get? balances {account: tx-sender})) none)
      (err u100))
    (map-set balances {account: tx-sender} {amount: total-supply})
    (ok true)))

(define-public (transfer (to principal) (amount uint))
  (let ((sender tx-sender))
    (begin
      (asserts! (> amount u0) (err u102)) ;; Fix: disallow zero-value transfers
      (match (map-get? balances {account: sender})
        balance-data
        (let ((sender-balance (get amount balance-data)))
          (if (>= sender-balance amount)
            (begin
              (map-set balances {account: sender} {amount: (- sender-balance amount)})
              (match (map-get? balances {account: to})
                recipient-data
                (let ((recipient-balance (get amount recipient-data)))
                  (map-set balances {account: to} {amount: (+ recipient-balance amount)}))
                (map-set balances {account: to} {amount: amount}))
              (ok true))
            (err u101)))
        (err u100)))))

(define-read-only (get-balance (account principal))
  (default-to u0 (get amount (map-get? balances {account: account}))))

(define-read-only (get-total-supply)
  total-supply)

(define-public (burn (amount uint))
  (let ((sender tx-sender))
    (match (map-get? balances {account: sender})
      balance-data
      (let ((sender-balance (get amount balance-data)))
        (if (>= sender-balance amount)
          (begin
            (map-set balances {account: sender} {amount: (- sender-balance amount)})
            (ok true))
          (err u201)))
      (err u200))))
