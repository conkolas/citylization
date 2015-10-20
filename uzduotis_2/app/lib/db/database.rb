require 'mongo'

class Database

  @@client
  def initialize database_name
    @@client = Mongo::Client.new([ 'localhost:27017' ], :database => database_name, :connect => :direct)
  end

  def client
    @@client
  end

  def self.create_user params
    if (!self.user_name_exists? params['name'], params['surname']) && (!self.user_email_exists? params['email'])
      result = @@client[:users].insert_one(
        {
            name: params['name'],
            surname: params['surname'],
            email: params['email'],
            pass: params['password']
        }
      )

      result.n
    else
      0
    end
  end

  def self.user_name_exists? name, surname

    result = @@client[:users].find(:name => name, :surname => surname).count

    if result > 0
      true
    else
      false
    end

  end

  def self.user_email_exists? email

    result = @@client[:users].find(:email => email).count

    if result > 0
      true
    else
      false
    end

  end
end