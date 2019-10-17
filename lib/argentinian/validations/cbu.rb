module Argentinian
  module Validations
    class Cbu < Base
      class BankError < StandardError; end
      class AccountError < StandardError; end

      def valid?
        numeric? && correct_length?(22) && correct_bank? && correct_account?
      end

      def validate!
        raise NotNumericError unless numeric?
        raise LengthError unless correct_length?(22)
        raise BankError unless correct_bank?
        raise AccountError unless correct_account?

        @value
      end

      private

      def correct_bank?
        correct = validate_block(@value[0..6], [7, 1, 3, 9, 7, 1, 3], @value[7])
        @errors << 'Bank is invalid' unless correct
        correct
      end

      def correct_account?
        correct = validate_block(
          @value[8..20], [3, 9, 7, 1, 3, 9, 7, 1, 3, 9, 7, 1, 3], @value[21]
        )
        @errors << 'Account is invalid' unless correct
        correct
      end

      def validate_block(block, multipliers, validation)
        block = string_to_int_array(block)
        checksum = sum_each_element(multiply_each_element(block, multipliers))

        if validation.to_i.zero?
          checksum_mod(checksum, 10) == 10
        else
          validation.to_i == checksum_mod(checksum, 10)
        end
      end
    end
  end
end
