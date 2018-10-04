((() => {
	const domLoaded = function domLoaded(){
		document.removeEventListener("readystatechange",domLoaded);
		document.querySelectorAll("li").forEach(li => {
			console.log(li);
			if( li.innerHTML.indexOf( '[' ) !== -1 ){
				li.innerHTML = li.innerHTML.replace(/\[ \]/g, '☐');
				li.innerHTML = li.innerHTML.replace(/\[x\]/g, '☒');
			}
		} );
	}

	console.log("I get here");
	if(document.readyState == "loading"){

		//If the dom hasn't loaded, wait until it is
		document.addEventListener("readystatechange",domLoaded);
		return;
	} else {
		//If it has, run the domLoaded function
		domLoaded();
	}
}))();
