require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe "localization" do
    before(:each) do
      FastGettext.available_locales = ["de", "en"]
    end

    it { should use_before_action(:localize) }

    it "has de as default locale" do
      @request.cookies['locale'] = nil
      put :change_locale, params: { locale: "" }
      expect(FastGettext.locale).to eq("de")
    end

    describe "with cookie set" do
      before(:each) do
        @request.cookies['locale'] = "en"
      end

      it "changes locale in cookie" do
        put :change_locale, params: { locale: "de" }
        expect(response.cookies['locale']).to eq("de")
      end

      it "does not change locale in cookie if not a known language" do
        put :change_locale, params: { locale: "unknown" }
        # we have to test for the locale, as we do not get the cookie value if it didn't change...
        expect(FastGettext.locale).to eq("en")
      end
    end

    it "redirects back" do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      put :change_locale, params: { locale: "en" }
      expect(response).to redirect_to("where_i_came_from")
    end
  end
end
