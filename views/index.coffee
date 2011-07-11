h1 'Claw collab chat'

div id: 'chat_room', ->
	div id: 'chat_messages'
		ul
	div id: 'chat_input_container', ->	
		div id: 'user_name_container', ->
			form action: '', method: 'post', ->
				span 'Name : '
				input type: 'text', name: 'user_name_field'
				input type: 'submit', name: 'send_user_name'
		div id: 'chat_message_input_container', style: 'display:none', ->
			form action: '', method: 'post', ->
				span 'Message : '
				input type: 'text', name: 'chat_input_field'
				input type: 'submit', name: 'send_chat_message'
