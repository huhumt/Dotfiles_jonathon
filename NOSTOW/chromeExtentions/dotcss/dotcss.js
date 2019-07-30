if(window.location.host.indexOf(".local") == -1){
	var xhr = new XMLHttpRequest();
	xhr.open('GET', 'https://dotcss.local.jh/' + window.location.host.replace(/^www\./, '') + '.css');

	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4) {
			if(xhr.status == 200) {
				var style = document.createElement('style');
				style.textContent = xhr.responseText;
				document.head.appendChild(style);
				return
			} else if(xhr.status == 404) {
				var defaultXHR = new XMLHttpRequest();
				defaultXHR.open('GET', 'https://dotcss.local.jh/default.css');
				defaultXHR.onreadystatechange = function() {
					if (defaultXHR.readyState == 4 && defaultXHR.status == 200){
						var style = document.createElement('style');
						style.textContent = defaultXHR.responseText;
						document.head.appendChild(style);
						return;
					}
				}
				defaultXHR.send();
			}
		}
	};

	xhr.send();
}
