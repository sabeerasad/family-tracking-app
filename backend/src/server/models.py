from . import db

# * pseudocode (werkzeug.security for encryption)
# User
#   id
#   firstName
#   lastName
#   mobileNumber
#   email
#   password
#   familyId
#   locationX
#   locationY
#   status

# Family
#   id
#   member(s)
#   familyName

# TODO: `counter`
class Counter(db.Model):
    client = db.Column(db.String)
    count = db.Column(db.Integer)