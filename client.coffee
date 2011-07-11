$ = require('jquery');
dnode = require('dnode');

$(document).ready ->
	
	# On présélectionne les formulaires afin d'accélerer le traitement par la suite
	$name_form = $('#user_name_container form')
	$chat_message_form = $('#chat_message_input_container form')
	$message_input_field = $chat_message_form.find('input[name=chat_input_field]')
	$messages_container = $('#chat_messages ul')
	
	
	add_line = (css_class, html_nodes...) ->
		$li = $('<li/>').addClass(css_class)
		$li.append(node) for node in html_nodes
		$messages_container.append $li
	
	launch_chat = (user_name) ->
		dnode( ->
			# Création de l'objet décrivant l'interface avec le "Client"
			this.name = user_name
			this.joined = (user_name) ->
				add_line('user_connects', user_name + ' has joined')
			this.parted = (user_name) ->
				add_line('user_disconnects', user_name + ' has parted')
			this.said = (user_name, msg) ->
				add_line(
					'chat_message',
					$('<span/>')
						.addClass('user_name')
						.html(user_name),
					' wrote : '
					$('<p/>')
						.addClass('user_message')
						.html(msg)
				)
			# Retourne this sinon fait perdre 2 bonnes heures à comprendre pourquoi
			# l'objet récupéré par app.coffee dans le `con.on 'ready'` ne contient nos propriétés
			# Merci coffeescript ! fuckaz
			this
		).connect (remote) ->
			$chat_message_form
				.submit ->
					message = $message_input_field.val()
					remote.say message
					$message_input_field.val('')
					false
	
	# Lors de la soumission du nom
	$name_form
		.submit (e) ->
			user_name = $name_form.find('input[name="user_name_field"]').val()
			launch_chat user_name
			$name_form.fadeOut 300, ->
				$('#chat_message_input_container').fadeIn 300
			false
				