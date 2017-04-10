require 'spec_helper'

describe TempMailRu::Api do
  context "Using API" do
    describe "Using API temp-mail.ru" do
      let(:client_id) { ENV['CLIENT_ID'] }
      let(:client_secret) { ENV['CLIENT_SECRET'] }
      let(:tempmailru_api) { described_class.new(nil, "http") } 
      let(:domain) { tempmailru_api.domains[0] }
      let(:email) { "testing#{domain}" }
      let(:email_params) {
        {
          html: '<html><body><h1>HTML</h1></body></html>',
          text: 'Text',
          subject: 'Subject',
          from: {
            name: Faker::Name.name,
            email: ENV['FROM_EMAIL']
          },
          to: [
            {
              name: Faker::Name.name,
              email: email
            }
          ]
        }
      }
      let(:sendpulse_smtp) { SendPulse::Smtp.new(client_id, client_secret, "https", nil) } 

      before do 
        sendpulse_smtp.send_email(email_params)
        sleep 2
        tempmailru_api.email = email
      end

      it do 
        expect(tempmailru_api).to be_a TempMailRu::Api
        expect(tempmailru_api.domains).to be_a Array
        inbox = tempmailru_api.inbox[0]
        expect(inbox).to include(:_id)
        expect(inbox).to include(:createdAt)
        expect(inbox).to include(:mail_id)
        expect(inbox).to include(:mail_address_id)
        expect(inbox).to include(:mail_from)
        expect(inbox).to include(:mail_subject)
        expect(inbox).to include(:mail_preview)
        expect(inbox).to include(:mail_text_only)
        expect(inbox).to include(:mail_text)
        expect(inbox).to include(:mail_html)
        expect(inbox).to include(:mail_timestamp)
      end

      it do
        source = tempmailru_api.source[0]
        expect(source).to include(:_id)
        expect(source).to include(:createdAt)
        expect(source).to include(:mail_id)
        expect(source).to include(:mail_address_id)
        expect(source).to include(:mail_source)
        expect(source).to include(:mail_timestamp)
      end

      it do
        expect(tempmailru_api.delete).to eql({ :result => "success" })
      end
    end
  end
end
