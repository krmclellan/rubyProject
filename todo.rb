#Classes

module Menu
  def menu
  	"Welcome to ToDo List! 
  	Here are your menu options: 
  	1) Add 
 	2) Show
	3) Write to a File
	4) Read from a File
	Q) Quit "
  end

  def show
  	menu
  end
end

module Promptable
  def prompt(message = 'What would you like to do?', symbol = ':>')
  	print message
  	print symbol
  	gets.chomp
  end
end

class List
	attr_reader :all_tasks
	
	def initialize
		@all_tasks = []
	end

	def add(task)
		all_tasks << task
	end

	def show
		all_tasks
	end

	def write_to_file(filename)
		IO.write(filename, @all_tasks.select(&:to_s).join("\n"))
	end

	def read_from_file(filename)
		IO.readlines(filename).each do |line| 
			add(Task.new(line.chomp))
		end
	end
end

class Task
	attr_reader :description

	def initialize(description)
		@description = description
	end

	def to_s
		description
	end
end


if __FILE__ == $PROGRAM_NAME
	
	include Menu
	include Promptable
	my_list = List.new
	puts "Please choose from the following lists: "
		until ['q'].include?(user_input = prompt(show).downcase)
			case user_input
			when "1"
				my_list.add(Task.new(prompt('What is the task you would like to accomplish?')))
			when "2"
				puts my_list.show
			when "3"
				my_list.write_to_file(prompt("What is the filename to write to?"))
			when "4"
				begin
					my_list.read_from_file(prompt("What file do you want to read?"))
				rescue Errno::ENOENT
					puts "File name not found, please verify your file name and path."
				end
			else
				puts "Sorry, I did not understand"
			end
			prompt('Press enter to continue', " ")
		end
	puts "Outro - Thanks for using the menu system!"
	end


#actions