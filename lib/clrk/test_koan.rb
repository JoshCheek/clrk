module TestKoan
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
end


class << TestKoan
  attr_accessor :execute_script

  def execute_script(script)
    @execute_script.call script
  end
end


module TestKoan
  def test_koan(options)
    TestKoan.execute_script ScriptBuilder.new(options).script
  end
end
