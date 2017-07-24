#delete hdmi here
#magic number 6 is found by `pacmd list-cards`, look for owner-module number
pactl unload-module 6

#configure a TCP streaming sink
pactl load-module module-null-sink sink_name=virtual_stream_sink
pacmd update-sink-proplist virtual_stream_sink device.description="TCP_Stream"
pactl load-module module-simple-protocol-tcp rate=44100 format=s16le channels=2 source=virtual_stream_sink.monitor record=true port=40001

