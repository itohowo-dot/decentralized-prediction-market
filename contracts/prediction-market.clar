;; Title: Decentralized Prediction Market
;;
;; Summary:
;; A decentralized prediction market where users can stake STX tokens to predict price movements
;; and earn rewards for correct predictions. The contract handles market creation, user predictions,
;; result resolution, and reward distribution with built-in fee mechanisms.
;;
;; Description:
;; - Markets are created by contract owner with start/end prices and block heights
;; - Users make "up" or "down" predictions by staking STX
;; - Oracle resolves markets by providing final prices
;; - Winners can claim proportional rewards minus platform fees
;; - Includes safety measures and administrative controls

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-invalid-prediction (err u102))
(define-constant err-market-closed (err u103))
(define-constant err-already-claimed (err u104))
(define-constant err-insufficient-balance (err u105))
(define-constant err-invalid-parameter (err u106))

;; Data Variables
;; Oracle address for resolving markets
(define-data-var oracle-address principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
;; Minimum required stake (1 STX)
(define-data-var minimum-stake uint u1000000)
;; Platform fee percentage
(define-data-var fee-percentage uint u2)
;; Auto-incrementing market ID counter
(define-data-var market-counter uint u0)

;; Data Maps
;; Stores market information including stakes and status
(define-map markets
  uint  ;; market-id
  {
    start-price: uint,
    end-price: uint,
    total-up-stake: uint,
    total-down-stake: uint,
    start-block: uint,
    end-block: uint,
    resolved: bool
  }
)

;; Stores user predictions and claims status
(define-map user-predictions
  {market-id: uint, user: principal}
  {prediction: (string-ascii 4), stake: uint, claimed: bool}
)

;; Market Management Functions

(define-public (create-market (start-price uint) (start-block uint) (end-block uint))
  (let
    ((market-id (var-get market-counter)))
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (> end-block start-block) err-invalid-parameter)
    (asserts! (> start-price u0) err-invalid-parameter)
    
    (map-set markets market-id
      {
        start-price: start-price,
        end-price: u0,
        total-up-stake: u0,
        total-down-stake: u0,
        start-block: start-block,
        end-block: end-block,
        resolved: false
      }
    )
    (var-set market-counter (+ market-id u1))
    (ok market-id)
  )
)