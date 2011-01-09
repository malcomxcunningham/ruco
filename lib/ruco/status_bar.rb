module Ruco
  class StatusBar
    def initialize(editor, options)
      @editor = editor
      @options = options
    end

    def view
      "Ruco #{Ruco::VERSION} -- #{@editor.file}#{change_indicator}#{writable_indicator}"
    end

    def format
      Curses::A_REVERSE
    end

    def change_indicator
      @editor.modified? ? '*' : ' '
    end

    def writable_indicator
      @writeable ||= begin
        writable = (not File.exist?(@editor.file) or system("test -w #{@editor.file}"))
        writable ? ' ' : '!'
      end
    end
  end
end