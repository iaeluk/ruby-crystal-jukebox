class Jukebox
  def initialize
    @name = nil
  end

  def find_song(song_name, directory)
    unless Dir.exist?(directory)
      puts "Directory not found."
      return
    end

    song_name_words = song_name.downcase.split(' ')
    entries = Dir.glob(File.join(directory, "*mp3"))

    entries.each do |name|
      file_name = File.basename(name, ".mp3").downcase

      if song_name_words.all? { |word| file_name.include?(word) }
        @name = name
        break
      end
    end

    if @name.nil?
      puts "Song not found."
    end
  end

  def play
    if @name
      puts "Now playing: #{@name}"
      `cvlc "#{@name}"`
    else
      puts "No song selected."
    end
  end
end

jukebox = Jukebox.new
print "Digite o nome da música: "
jukebox.find_song(gets.chomp, "/home/lucas/Músicas")
jukebox.play
