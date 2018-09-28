while i < j # will do the while loop until the end of my_words
  while my_words[i] == " " && i < j
    i += 1
  end
  s_index = i

  while my_words[i] != " " && i < j
    i += 1
  end
  e_index = i - 1

  string_reverse(my_words, s_index, e_index)
end
return my_words
