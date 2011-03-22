class String
  #return a passage of size <= length from start_indexth sentence
  def extract_passage(start_index=0,length=500)
    sentences = self.split_sentences
    stop = ((start_index+1)...sentences.size).detect { |i| (sentences[start_index..i].join('. ')).size > length }
    stop = (stop and stop <= sentences.size)? stop-1 : sentences.size - 1
    passages = sentences[start_index...stop].join('. ').split("\n")
    (passages.size > 0)? passages[0].gsub(/^[^\w]+/,'').limit(length) : ''
  end
  
  #split text into sentences, take into account Mr.|Ms. endings are not end of sentence
  def split_sentences
    #break text first by paragraph then into chunks delimited by a period
    #but these are not quite sentences yet
    chunks = (self.split(/\n+/).map { |p| "#{p}\n".split(/\.(?:[^\w])/) }).flatten.compact
  
    #if a sentence is split at Mr.|Ms.|Dr.|Mrs. 
    #then recombine it with its remaining part and nil it to delete later
    tmp=''
    sentences = chunks.map { |c|
      ss = (tmp != '')? "#{tmp}. #{c}" : c
      if c.match(/(?:Dr|Mr|Ms|Mrs)$/) #what about John F. Kennedy ([A-Z])
        tmp = ss
        ss=nil
      else
        tmp = ''
      end
      ss
    } 
    sentences.compact #delete nil elements
  end
  
  #constraint a string to a fixed length or less
  #discard everything after the last punctuation that occurs right before lenght limit
  #the regexp look ahead for any punctuation
  def limit(length)
    (self.length > length)? self[0...length].gsub(/(?![\s\S]+?[,:;)\/\\\|])([,:;)\/\\\|].*)/,'') : self
  end
end