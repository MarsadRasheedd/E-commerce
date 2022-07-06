Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.dig(:publishable_key),
  secret_key:      Rails.application.credentials.dig(:secret_key)
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
