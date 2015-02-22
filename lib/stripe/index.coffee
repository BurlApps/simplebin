stripeKey = ""

if isProduction
  stripeKey = config.stripe.production
else
  stripeKey = config.stripe.development

module.exports = require("stripe")(stripeKey)
