module.exports = (sequelize, DataTypes)->
  return sequelize.define "User",
    name: DataTypes.STRING
    address: DataTypes.STRING
    day: DataTypes.STRING
    stripe: DataTypes.STRING
    password: DataTypes.STRING
    email:
      type: DataTypes.STRING
      validate:
        isUnique: (value, next)->
          lib.orm.models.User.find
            where: email: value
          .then (user)->
            if user
              return next "Email address already in use!"

            next()
  ,
    hooks:
      beforeCreate: (user, options, cb)->
        user.addStripe().then ->
          cb null, user
        .catch (error)->
          cb error

    classMethods:
      hash: (string)->
        return lib.core.hash string

    instanceMethods:
      addStripe: ->
        return new Promise (resolve, reject)=>
          lib.stripe.customers.create
            email: this.email
            plan: config.stripe.plan
            coupon: config.stripe.coupon
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
