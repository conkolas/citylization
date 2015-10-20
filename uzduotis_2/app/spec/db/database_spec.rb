require 'rspec'

require_relative "../../lib/config"
require_relative "../../lib/db/database"

describe 'Database' do

  before (:all) do
    @db = Database.new DATABASE_NAME
  end

  describe "Connection" do

    it 'connects to database from config file' do
      expect(@db.client.database.name).to eq(DATABASE_NAME)
    end

    it 'have at least 1 server running' do
      expect(@db.client.cluster.servers.count).to be > 0
    end
  end

  describe "User registration" do
    params = {
        name: "name123",
        surname: "surnamename123",
        email: "test@test.com",
        pass: "test_pass"
    }

    before (:all) do
      @db.client[:users].find(:email => params['email']).delete_many
    end
    after (:all) do
      @db.client[:users].find(:email => params['email']).delete_many
    end

    it 'saves single user' do
      save_one = Database.create_user params
      expect(save_one).to eq(1)
    end

    it 'checks for existing user name' do
      expect(Database.user_name_exists? params['name'], params['surname']).to be true
    end
    it 'checks for existing email' do
      expect(Database.user_email_exists? params['email']).to be true
    end

    it 'saves unique user' do
      save_two = Database.create_user params
      expect(save_two).to eq(0)
    end
  end
end