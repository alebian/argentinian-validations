describe Argentinian::Validations::Cbu do
  subject(:validator) { described_class.new(cbu) }

  let(:valid_cbu) { '2850590940090418135201' }
  let(:invalid_character_cbu) { '28505909 40090418135201' }
  let(:invalid_length_cbu) { '285059094009041813520' }
  let(:invalid_bank_cbu) { '1850590940090418135201' }
  let(:invalid_account_cbu) { '2850590940090408135201' }

  describe '.valid?' do
    context 'when cbu is valid' do
      let(:cbu) { valid_cbu }

      it 'returns true' do
        expect(validator).to be_valid
      end
    end

    context 'when cbu has invalid characters' do
      let(:cbu) { invalid_character_cbu }

      it 'returns false' do
        expect(validator).not_to be_valid
      end

      it 'adds an error message' do
        validator.valid?
        expect(validator.errors).to include('Value is not numeric')
      end
    end

    context 'when cbu has invalid length' do
      let(:cbu) { invalid_length_cbu }

      it 'returns false' do
        expect(validator).not_to be_valid
      end

      it 'adds an error message' do
        validator.valid?
        expect(validator.errors).to include('Value length must be 22 characters')
      end
    end

    context 'when cbu has invalid bank' do
      let(:cbu) { invalid_bank_cbu }

      it 'returns false' do
        expect(validator).not_to be_valid
      end

      it 'adds an error message' do
        validator.valid?
        expect(validator.errors).to include('Bank is invalid')
      end
    end

    context 'when cbu has invalid account' do
      let(:cbu) { invalid_account_cbu }

      it 'returns false' do
        expect(validator).not_to be_valid
      end

      it 'adds an error message' do
        validator.valid?
        expect(validator.errors).to include('Account is invalid')
      end
    end
  end

  describe '.validate!' do
    context 'when cbu is valid' do
      let(:cbu) { valid_cbu }

      it 'returns the cbu' do
        expect(validator.validate!).to eq(cbu)
      end
    end

    context 'when cbu has invalid characters' do
      let(:cbu) { invalid_character_cbu }

      it 'raises a NotNumericError' do
        expect { validator.validate! }
          .to raise_error(Argentinian::Validations::Base::NotNumericError)
      end
    end

    context 'when cbu has invalid length' do
      let(:cbu) { invalid_length_cbu }

      it 'raises a LengthError' do
        expect { validator.validate! }.to raise_error(Argentinian::Validations::Base::LengthError)
      end
    end

    context 'when cbu has invalid bank' do
      let(:cbu) { invalid_bank_cbu }

      it 'raises a BankError' do
        expect { validator.validate! }.to raise_error(Argentinian::Validations::Cbu::BankError)
      end
    end

    context 'when cbu has invalid account' do
      let(:cbu) { invalid_account_cbu }

      it 'raises a AccountError' do
        expect { validator.validate! }.to raise_error(Argentinian::Validations::Cbu::AccountError)
      end
    end
  end
end
