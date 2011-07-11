$ = require('jquery');
dnode = require('dnode');

$(document).ready ->
	
	# On présélectionne les formulaires afin d'accélerer le traitement par la suite
	$name_form = $('#user_name_container form')
	$chat_message_form = $('#chat_message_input_container form')
	$messages_container = $('#chat_messages ul')
	
	add_line = (css_class, html_nodes...) ->
		$messages_container
			.append $('<li/>').addClass(css_class).append(html_nodes)
	# Lors de la soumission du nom
	$name_form
		.submit (e) ->
			dnode( ->
				this.name = $name_form.find('input[name="user_name_field"]').val();
				this.joined = (who) ->
					add_line('user_connects', who + ' has joined')
				this.parted = (who) ->
					add_line('user_connects', who + ' has parted')
				this.said = (who, msg) ->
					add_line(
						'chat_message',
						$('<span/>')
							.addClass('user_name')
							.html(name),
						' wrote : '
						$('<p/>')
							.addClass('user_message')
							.html(msg)
					)
			).connect (remote) ->
				$chat_message_form
					.submit ->
						return false if not current_user_name?
						user_name = $form.find('input[name=user_name_field]').val()
						message = $form.find('input[name=chat_input_field]').val()
						remote.say message
						false
			return false