require "spec_helper"
require "rack/test"
require "sinatra"

describe Sinatra::Protection do
  include Rack::Test::Methods

  class AppWithDefaults < Sinatra::Application
    register Sinatra::Protection

    get "/protected" do
      protected!
      "OK"
    end

    get "/unprotected" do
      "OK"
    end
  end

  describe "with defaults" do
    let(:app) { AppWithDefaults }

    it "blocks the access to the protected endpoint" do
      get "/protected"

      expect(last_response.status).to eq(401)
    end

    it "does not block access to the unprotected endpoint" do
      get "/unprotected"

      expect(last_response.status).to eq(200)
    end

    it "allows bypassing protection with admin/admin credentials" do
      basic_authorize "admin", "admin"

      get "/protected"

      expect(last_response.status).to eq(200)
    end

    it "blocks the access to the protected endpoint with invalid password" do
      basic_authorize "admin", "pass"

      get "/protected"

      expect(last_response.status).to eq(401)
    end
  end

  class ConfiguredApp < AppWithDefaults
    set :username, "demo"
    set :password, "pass"
  end

  describe "with set username/password" do
    let(:app) { ConfiguredApp }

    it "blocks the access to the protected endpoint" do
      get "/protected"

      expect(last_response.status).to eq(401)
    end

    it "does not block access to the unprotected endpoint" do
      get "/unprotected"

      expect(last_response.status).to eq(200)
    end

    it "allows bypassing protection with the configured credentials" do
      basic_authorize "demo", "pass"

      get "/protected"

      expect(last_response.status).to eq(200)
    end

    it "blocks the access to the protected endpoint with invalid password" do
      basic_authorize "admin", "admin"

      get "/protected"

      expect(last_response.status).to eq(401)
    end
  end

  class ProtectionDisabled  < AppWithDefaults
    set :enable_protection, false
  end

  describe "when protection disabled" do
    let(:app) { ProtectionDisabled }

    it "does not block access to the protected endpoint" do
      get "/protected"

      expect(last_response.status).to eq(200)
    end

    it "does not block access to the unprotected endpoint" do
      get "/unprotected"

      expect(last_response.status).to eq(200)
    end
  end
end
