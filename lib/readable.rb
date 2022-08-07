module Readable
  def write(file_path, type)
    if type == 'encrypt'
      File.write("#{file_path}", "#{encryption}, #{key}, #{date}\n", mode: 'a')
    elsif type == 'decrypt'
      File.write(file_path, "#{message}, #{key}, #{date}", mode: 'a')
    end
  end

  def status_message(file_path)
    "Created '#{File.basename("#{file_path}")}' with the key #{key} and the date #{date}"
  end

  def shift_type(type, message, *data)
    require "pry"; binding.pry
    message = message.flatten
    if type == 'encrypt'
      encrypt(message[0], *data[0], *data[1])
    elsif type == 'decrypt'
      decrypt(message[0], data[0], *data[1])
    end
  end

  def read_message(read_file_path, write_file_path, *data, type)
    File.foreach("#{read_file_path}") do |line|
      working_line = line.chomp.downcase.split(', ')
      shift_type(type, working_line, *data)
      write(write_file_path, type)
      puts status_message(write_file_path)
    end
  end

  # def encrypt_write(file_path)
  #   File.write(file_path, "#{encryption}, #{key}, #{date}", mode: 'a')
  # end

  # def decrypt_write(file_path)
  #   File.write(file_path, "#{message}, #{key}, #{date}", mode: 'a')
  # end

  #   def read_encrypted_message(read_file_path, write_file_path, type)
  #     File.foreach(read_file_path) do |line|
  #       working_line = line.downcase.split(', ')
  #       if working_line.count == 3
  #       encrypt(working_line[0],working_line[1], working_line[2])
  #         decrypt_write('./lib/decrypted.txt')
  #         puts "Created 'decrypted.txt' with the key #{key} and the date #{date}"
  #       elsif working_line.count == 2
  #         encrypt(working_line[0],working_line[1])
  #         encrypt_write('./lib/decrypted.txt')
  #         puts "Created 'decrypted.txt' with the key #{key} and the date #{date}"
  #       elsif working_line.count == 1
  #         encrypt(working_line[0])
  #         encrypt_write('./lib/decrypted.txt')
  #         puts "Created 'decrypted.txt' with the key #{key} and the date #{date}"
  #       end
  #     end
  #   end
end
