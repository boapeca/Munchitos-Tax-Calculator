require 'rails_helper'

RSpec.describe TaxesController, type: :controller do
  describe "GET #calculate" do
    context "with valid parameters and a transaction is a Good" do
      it "returns the calculated tax and tax type if its individual in Spain" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "individual",
          product_type: "good",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(21)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("VAT")
      end
    end

    context "with valid parameters and a transaction is a Good" do
      it "returns the calculated tax and tax type if its company in Spain" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "company",
          product_type: "good",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(21)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("VAT")
      end
    end

    context "with valid parameters and a transaction is a Good" do
      it "returns the calculated tax and tax type if its individual in EU country" do
        get :calculate, params: {
          buyer_location: "Ireland",
          buyer_type: "individual",
          product_type: "good",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(23)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("VAT")
      end
    end

    context "with valid parameters and a transaction is a Good" do
      it "returns the calculated tax and tax type if its company in EU country" do
        get :calculate, params: {
          buyer_location: "Ireland",
          buyer_type: "company",
          product_type: "good",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(0)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("reverse charge")
      end
    end

    context "with valid parameters and a transaction is a Good" do
      it "returns the transaction as export if country is outside EU" do
        get :calculate, params: {
          buyer_location: "China",
          buyer_type: "company",
          product_type: "good",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(0)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("export")
      end
    end

    context "with valid parameters and a transaction is a service-digital" do
      it "returns the calculated tax and tax type if buyer(company) is in Spain" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "company",
          product_type: "service-digital",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(21)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("VAT")
      end
    end

    context "with valid parameters and a transaction is a service-digital" do
      it "returns the calculated tax and tax type if buyer(individual) is in Spain" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "individual",
          product_type: "service-digital",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(21)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("VAT")
      end
    end

    context "with valid parameters and a transaction is a service-digital" do
      it "returns the calculated tax and tax type if buyer(individual) is in EU" do
        get :calculate, params: {
          buyer_location: "Ireland",
          buyer_type: "individual",
          product_type: "service-digital",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(23)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("VAT")
      end
    end

    context "with valid parameters and a transaction is a service-digital" do
      it "returns the calculated tax and tax type if buyer(company) is in EU" do
        get :calculate, params: {
          buyer_location: "Ireland",
          buyer_type: "company",
          product_type: "service-digital",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(0)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("reverse charge")
      end
    end

    context "with valid parameters and a transaction is a service-digital" do
      it "returns the transaction as export if country is outside EU" do
        get :calculate, params: {
          buyer_location: "China",
          buyer_type: "company",
          product_type: "service-digital",
          price: 100.0,
          service_location: nil
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(0)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("no tax")
      end
    end

    context "with valid parameters and a transaction is a service-onsite" do
      it "returns the calculated tax and tax type if service provided is in Spain" do
        get :calculate, params: {
          buyer_location: "China",
          buyer_type: "company",
          product_type: "service-onsite",
          price: 100.0,
          service_location: "Spain"
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(21)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("VAT")
      end
    end

    context "with valid parameters and a transaction is a service-onsite" do
      it "returns the calculated tax and tax type if service provided is not in Spain" do
        get :calculate, params: {
          buyer_location: "China",
          buyer_type: "company",
          product_type: "service-onsite",
          price: 100.0,
          service_location: "England"
        }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("tax")
        expect(json_response["tax"]).to eq(0)
        expect(json_response).to have_key("tax_type")
        expect(json_response["tax_type"]).to eq("no tax")
      end
    end

    context "with buyer_location param missing" do
      it "returns an error listing the missing parameter" do
        get :calculate

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Missing required parameter: buyer_location")
      end
    end

    context "with buyer_type param missing" do
      it "returns an error listing the missing parameter" do
        get :calculate, params: {
          buyer_location: "Spain"
        }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Missing required parameter: buyer_type")
      end
    end

    context "with product_type param missing" do
      it "returns an error listing the missing parameter" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "individual"
        }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Missing required parameter: product_type")
      end
    end

    context "with price param missing" do
      it "returns an error listing the missing parameter" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "individual",
          product_type: "good"
        }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Missing required parameter: price")
      end
    end

    context "with invalid price format" do
      it "returns an error message for invalid price" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "individual",
          product_type: "good",
          price: "invalid_price",
          service_location: nil
        }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid price format")
      end
    end

    context "with invalid buyer type format" do
      it "returns an error message for invalid buyer type" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "invalid_buyer_type",
          product_type: "good",
          price: 100,
          service_location: nil
        }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid buyer_type: must be 'individual' or 'company'")
      end
    end

    context "with invalid product type format" do
      it "returns an error message for invalid product type" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "company",
          product_type: "invalid_product_type",
          price: 100,
          service_location: nil
        }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid product_type: must be 'good' , 'service-digital' or 'service-onsite'")
      end
    end

    context "with invalid service_location when product_type is onsite" do
      it "returns an error message explaining a value needs to be provided" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "company",
          product_type: "service-onsite",
          price: 100,
          service_location: nil
        }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Service location cannot be null or missing for service-onsite products")
      end
    end

    context "with missing service_location when product_type is onsite" do
      it "returns an error message explaining a value needs to be provided" do
        get :calculate, params: {
          buyer_location: "Spain",
          buyer_type: "company",
          product_type: "service-onsite",
          price: 100
        }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Service location cannot be null or missing for service-onsite products")
      end
    end
  end
end
