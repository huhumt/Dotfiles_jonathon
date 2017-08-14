if(window.location.host.indexOf(".local") != -1){
	var xhr = new XMLHttpRequest();
	xhr.open('GET', 'https://dotjs.local/' + window.location.host.replace(/^www\./, '') + '.js');

	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4) {
			if(xhr.status == 200) {
				var script = document.createElement('script');
				script.textContent = xhr.responseText;
				document.head.appendChild(script);
				return;
			} else if(xhr.status == 404) {
				var defaultXHR = new XMLHttpRequest();
				defaultXHR.open('GET', 'https://dotjs.local/default.js');
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
