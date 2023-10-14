class Jukebox

  def initialize
    @name = nil
  end

  def find_song(song_name, directory)
    unless Dir.exist?(directory)
      puts "Diretório não encontrado."
      return
    end

    song_name_words = song_name.downcase.split(' ')
    songs_in_directory = Dir.glob(File.join(directory, "*mp3"))

    songs_in_directory.each do |name|
      file_name = File.basename(name, ".mp3").downcase

      if song_name_words.all? { |word| file_name.include?(word) }
        @name = name
        break
      end
    end

    if @name.nil?
      puts "Música não encontrada."
    end
  end

  def play
    if @name
      song_name = File.basename(@name)
      puts "Tocando: #{song_name} \nPressione Ctrl + C para parar."
      `mpv --no-video "#{@name}"`
    else
      puts "Nenhuma música selecionada."
    end
  end
end

jukebox = Jukebox.new
print "Digite o nome da música: "
jukebox.find_song(gets.chomp, "/home/lucas/Músicas")
jukebox.play
