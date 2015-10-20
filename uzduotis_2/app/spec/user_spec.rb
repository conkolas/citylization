require 'rspec'
require File.expand_path '../../lib/user.rb', __FILE__

describe User do

  context 'Validation' do
    it 'validates email address' do
      invalid_email = "email@domain"
      valid_email = "email@domain.com"

      validates = 0
      if User.is_a_valid_email? valid_email
        validates+=1
      end

      if not User.is_a_valid_email? invalid_email
        validates+=1
      end

      expect(validates).to be(2)
    end

    it 'validates user name' do
      username = ''
      params = {'name' => username}
      errors = User.registration_errors params

      invalid_name = false
      errors.each { |error|
        if error.has_value?('name')
          invalid_name = true
        end
      }

      expect(invalid_name).to be(true)
    end
    it 'validates user surname' do
      surname = ''
      params = {'surname' => surname}
      errors = User.registration_errors params

      invalid_surname = false
      errors.each { |error|
        if error.has_value?('surname')
          invalid_surname = true
        end
      }

      expect(invalid_surname).to be(true)
    end
    it 'validates password' do
      password = '12345'
      params = {'password' => password}
      errors = User.registration_errors params

      invalid_password = false
      errors.each { |error|
        if error.has_value?('password')
          invalid_password = true
        end
      }

      expect(invalid_password).to be(true)
    end
    it 'validates matching password' do
      password_1 = '1234567'
      password_2 = '123456seven'
      params = {'password' => password_1, 'password_confirm' => password_2 }
      errors = User.registration_errors params

      invalid_password = false
      errors.each { |error|
        if error.has_value?('password_confirm')
          invalid_password = true
        end
      }

      expect(invalid_password).to be(true)
    end
  end
end