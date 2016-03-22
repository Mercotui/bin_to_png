def parse_line(line)
  address, code = line.split(":")
  code = code.split('#')[0] #filter out comments
  
  asm.strip!
  hex.strip!
  return hex, asm
end

