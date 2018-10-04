console.log( "yay" );
if(window.location.host.indexOf(".local.jh") == -1){
console.log( "I get here" );
	var xhr = new XMLHttpRequest();
	xhr.open('GET', 'https://dotjs.local.jh/' + window.location.host.replace(/^www\./, '') + '.js');

	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4) {
			if(xhr.status == 200) {
				var script = document.createElement('script');
				script.textContent = xhr.responseText;
				document.head.appendChild(script);
				return;
			} else if(xhr.status == 404) {
				var defaultXHR = new XMLHttpRequest();
				defaultXHR.open('GET', 'https://dotjs.local.jh/default.js');
				defaultXHR.onreadystatechange = function() {
					if (defaultXHR.readyState == 4 && defaultXHR.status == 200){
						var script = document.createElement('script');
						script.textContent = defaultXHR.responseText;
						document.head.appendChild(script);
						return;
					}
				}
				defaultXHR.send();
			}
		}
	};

	xhr.send();
}
