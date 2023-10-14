class Jukebox
  @name : String?

  def initialize
    @name = nil
  end

  def find_song(song_name : String, directory : String)
    unless Dir.exists?(directory)
      puts "Diretório não encontrado."
      return
    end

    song_name_words = song_name.downcase.split(' ')
    entries = Dir.glob("#{directory}/*.mp3")

    entries.each do |name|
      file_name = File.basename(name, ".mp3").downcase

      if song_name_words.all? { |word| file_name.includes?(word) }
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
      song_name = File.basename(@name.not_nil!)
      puts "Tocando: #{song_name} \nPressione Ctrl + C para parar."
      Process.run("mpv", ["--no-video", "#{@name}"])
    else
      puts "Nenhum música selecionada."
    end
  end
end

jukebox = Jukebox.new
print "Digite o nome da música: "
jukebox.find_song(gets.to_s.chomp, "/home/lucas/Músicas")
jukebox.play
