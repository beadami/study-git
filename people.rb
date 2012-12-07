class MetaPerson
  def MetaPerson.method_missing(methodName, *args)
    name = methodName.to_s
    begin
      class_eval(%Q[
        def #{name}
          puts '#{name}, #{name}, #{name}...'
        end
      ])
    rescue
    super(methodName, *args)
    end
  end

  def method_missing(methodName, *args)
    MetaPerson.method_missing(methodName, *args)
    send(methodName)
  end

  def MetaPerson.modify_method(methodName, methodBody)
    class_eval(%Q[
      def #{methodName}
        #{methodBody}
      end
    ])
  end

  def modify_method(methodName, methodBody)
    MetaPerson.modify_method(methodName, methodBody)
  end

end

class Person < MetaPerson
end
person1 = Person.new
person2 = Person.new
person1.sleep #sleep, sleep, sleep...
person1.running #running, running, running...
person1.modify_method("sleep", "puts 'ZZZ...'")
person1.sleep # ZZZ...
person2.sleep # ZZZ...
