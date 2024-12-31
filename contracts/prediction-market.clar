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