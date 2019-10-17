module Argentinian
  module Validations
    class Base
      class NotNumericError < StandardError; end
      class LengthError < StandardError; end

      attr_reader :value, :errors

      def initialize(value)
        @value = value.to_s
        @errors = []
      end

      def valid?
        raise 'Subclass must implement'
      end

      def validate!
        raise 'Subclass must implement'
      end

      private

      def numeric?
        !!Float(@value)
      rescue ArgumentError
        @errors << 'Value is not numeric'
        false
      end

      def correct_length?(length)
        correct = @value.length == length
        @errors << "Value length must be #{length} characters" unless correct
        correct
      end

      def string_to_int_array(string)
        string.split(//).map(&:to_i)
      end

      def multiply_each_element(array1, array2)
        array1.zip(array2).map { |a| a.reduce(:*) }
      end

      def checksum_mod(checksum, value)
        value - (checksum % value)
      end

      def sum_each_element(array)
        # Some Ruby versions do not have the method `sum` in the Enumerable module
        array.inject(0) { |sum, element| sum + element }
      end
    end
  end
end
