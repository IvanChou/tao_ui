require 'tao_on_rails/components/base'

module TaoUi
  module Components
    class SlideBoxComponent < TaoOnRails::Components::Base

      def initialize view, options
        super

        unless @options[:with_close_button].in? [true, false]
          @options[:with_close_button] = true
        end
      end

      def self.component_name
        :slide_box
      end

    end
  end
end