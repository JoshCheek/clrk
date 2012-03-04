class CLRK
  class TestKoan
    class ScriptBuilder
      attr_accessor :options

      def initialize(options)
        self.options = options
      end

      def script
        if stdin
          "cat #{stdin} | ruby #{rendered}"
        else
          "#{rendered} #{argv.join ' '}"
        end
      end

      def stdin
        options[:stdin]
      end

      def argv
        Array(options[:argv])
      end

      def rendered
        ""
      end
    end

    attr_accessor :koan_dir, :execute_script

    def initialize(koan_dir, &execute_script)
      self.koan_dir, self.execute_script = koan_dir, execute_script
    end

    def execute_script(script)
      @execute_script.call script
    end

    def test_koan(options)
      execute_script ScriptBuilder.new(options).script
    end
  end
end
