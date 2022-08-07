module Readable
  def write(file_path, type)
    if type == 'encrypt'
      File.write("./lib/#{file_path}", "#{encryption}\n", mode: 'a')
    elsif type == 'decrypt'
      File.write("./lib/#{file_path}", "#{message}\n", mode: 'a')
    end
  end

  def status_message(file_path)
    "Created '#{File.basename("./lib/#{file_path}")}' with the key #{key} and the date #{date}"
  end

  def shift_type(type, message, *data)
    message = message.flatten
    if type == 'encrypt'
      encrypt(message[0], *data[0], *data[1])
    elsif type == 'decrypt'
      decrypt(message[0], data[0], *data[1])
    end
  end

  def read_message(read_file_path, write_file_path, *data, type)
    File.foreach("./lib/#{read_file_path}") do |line|
      working_line = line.chomp.downcase.split(', ')
      shift_type(type, working_line, *data)
      write(write_file_path, type)
      puts status_message(write_file_path)
    end
  end
end
