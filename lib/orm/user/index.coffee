module.exports = (sequelize, DataTypes)->
  return sequelize.define "User",
    name: DataTypes.STRING
    address: DataTypes.STRING
    email: DataTypes.STRING
    stripe: DataTypes.STRING
  ,
    hooks:
      beforeCreate: (user, options, cb)->
        user.addStripe().then ->
          cb null, user
        .catch (error)->
          cb error

    instanceMethods:
      addStripe: ->
        return new Promise (resolve, reject)=>
          lib.stripe.customers.create
            email: this.email
            plan: config.stripe.plan
          , (error, customer)=>
            if not error and customer
              this.stripe = customer.id
              resolve()
            else
              reject(error)

      addCard: (card, expiration, cvc)->
        return new Promise (resolve, reject)=>
          lib.stripe.customers.createCard this.stripe,
            card:
              name: this.name,
              number: card,
              exp_month: expiration.month,
              exp_year: expiration.year,
              cvc: cvc
          , (error, card)=>
            if not error and card
              resolve()
            else
              reject(error)
