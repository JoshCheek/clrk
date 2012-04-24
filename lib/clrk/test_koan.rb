class CLRK
  class TestKoan
    class ScriptBuilder
      attr_accessor :options

      def initialize(script_body, options)
        self.script_body, self.options = script_body, options
      end

      def script
        if stdin
          "cat #{stdin} | #{script_body}"
        else
          "#{script_body} #{argv.join ' '}"
        end
      end

      def stdin
        options[:stdin]
      end

      def argv
        Array(options[:argv])
      end
    end
  end


  class TestKoan
    attr_accessor :koan_dir, :execute_script

    def initialize(koan_dir, &execute_script)
      self.koan_dir, self.execute_script = koan_dir, execute_script
    end

    def execute_script(script)
      @execute_script.call script
    end

    def test_koan(options)
      output = execute_script ScriptBuilder.new(script_body, options).script
      output.should == output_file_contents(options.fetch :result)
    end

    def output_file_contents(output_file)
      File.read output_file
    end

    def script_body
      script_getter.call script_file
    end

    def script_file
      koan_dir + "/solution"
    end
  end
end
