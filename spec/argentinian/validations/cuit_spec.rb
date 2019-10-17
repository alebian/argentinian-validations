describe Argentinian::Validations::Cuit do
  subject(:validator) { described_class.new(cuit) }

  let(:valid_cuit) { '30707026851' }
  let(:invalid_character_cuit) { '30-70702685-1' }
  let(:invalid_length_cuit) { '3070702851' }
  let(:invalid_cuit) { '20707026851' }

  describe '.valid?' do
    context 'when cuit is valid' do
      let(:cuit) { valid_cuit }

      it 'returns true' do
        expect(validator).to be_valid
      end
    end

    context 'when cuit has invalid characters' do
      let(:cuit) { invalid_character_cuit }

      it 'returns false' do
        expect(validator).not_to be_valid
      end

      it 'adds an error message' do
        validator.valid?
        expect(validator.errors).to include('Value is not numeric')
      end
    end

    context 'when cuit has invalid length' do
      let(:cuit) { invalid_length_cuit }

      it 'returns false' do
        expect(validator).not_to be_valid
      end

      it 'adds an error message' do
        validator.valid?
        expect(validator.errors).to include('Value length must be 11 characters')
      end
    end

    context 'when cuit has invalid bank' do
      let(:cuit) { invalid_cuit }

      it 'returns false' do
        expect(validator).not_to be_valid
      end

      it 'adds an error message' do
        validator.valid?
        expect(validator.errors).to include('CUIT is invalid')
      end
    end
  end

  describe '.validate!' do
    context 'when cuit is valid' do
      let(:cuit) { valid_cuit }

      it 'returns the cuit' do
        expect(validator.validate!).to eq(cuit)
      end
    end

    context 'when cuit has invalid characters' do
      let(:cuit) { invalid_character_cuit }

      it 'raises a NotNumericError' do
        expect { validator.validate! }
          .to raise_error(Argentinian::Validations::Base::NotNumericError)
      end
    end

    context 'when cuit has invalid length' do
      let(:cuit) { invalid_length_cuit }

      it 'raises a LengthError' do
        expect { validator.validate! }.to raise_error(Argentinian::Validations::Base::LengthError)
      end
    end

    context 'when cuit has invalid bank' do
      let(:cuit) { invalid_cuit }

      it 'raises a CuitError' do
        expect { validator.validate! }
          .to raise_error(Argentinian::Validations::Cuit::InvalidNumberError)
      end
    end
  end
end
