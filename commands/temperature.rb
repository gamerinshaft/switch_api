require 'pi_piper'
value = 0
raw = 0
PiPiper::Spi.begin do |spi|
  raw = spi.write [0b01101000, 0]
  value = ((raw[0] << 8) + raw[1]) & 0x03FF
end
volt = (value * 3300) / 1024
degree = volt / 10.0

File.open(ARGV[0], 'w') do |file|
  file.print(degree)
end
