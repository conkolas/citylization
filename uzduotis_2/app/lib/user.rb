require_relative "db/database"

class User

  def self.is_a_valid_email? email
    email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
  end

  def self.registration_errors params
    name = params['name']
    surname = params['surname']
    email = params['email']
    pass = params['password']
    pass_confirm = params['password_confirm']

    errors = []

    name_surname_set = true
    if (name != nil) && (name.length <= 0)
      name_surname_set = false
      errors.push( {:class => 'name', :message => 'Name should not be empty'} )
    end
    if (surname != nil) && (surname.length <= 0)
      name_surname_set = false
      errors.push( {:class => 'surname', :message => 'Surname should not be empty'} )
    end

    if name_surname_set
      if Database.user_name_exists? name, surname
        errors.push( {:class => 'name', :message => 'Name and surname combination already exists'} )
        errors.push( {:class => 'surname', :message => 'Name and surname combination already exists'} )
      end
    end

    if (pass != nil) && (pass.length <= 6)
      errors.push( {:class => 'password', :message => 'Password should be more than 6 characters'} )
    end

    if !pass.eql? pass_confirm
      errors.push( {:class => 'password_confirm', :message => 'Passwords must match'} )
    end

    if not self.is_a_valid_email? email
      errors.push( {:class => 'email', :message => 'Email is not valid'} )
    else
      if Database.user_email_exists? email
        errors.push( {:class => 'email', :message => 'Email already exists'} )
      end
    end

    errors
  end

  def self.register params
    validation = self.registration_errors params

    if validation.empty?
      if Database.create_user(params) == 1
        response = {:success => 1, :errors => {:validation => {}, :database => {}}}
      else
        response = {:success => 0, :errors => {:validation => {}, :database => "Could not save user."}}
      end
    else
      response = {:success => 0, :errors => {:validation => validation, :database => {}}}
    end

    response
  end
end