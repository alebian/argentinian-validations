module Argentinian
  module Validations
    class Cuit < Base
      class CuitError < StandardError; end

      def valid?
        numeric? && correct_length?(11) && correct_number?
      end

      def validate!
        raise NotNumericError unless numeric?
        raise LengthError unless correct_length?(11)
        raise CuitError unless correct_number?

        @value
      end

      private

      def correct_number?
        correct = validate_block!(@value[0..-2], [5, 4, 3, 2, 7, 6, 5, 4, 3, 2], @value[-1])
        @errors << 'CUIT is invalid' unless correct
        correct
      end

      def validate_block!(block, multipliers, validation)
        block = string_to_int_array(block)
        checksum = checksum_mod(multiply_each_element(block, multipliers).sum, 11)

        if checksum == 11
          checksum = 0
        elsif checksum == 10
          raise CuitError
        end

        validation.to_i == checksum
      end
    end
  end
end
