//This script will ensure that code mirror code is always gruvbox dark

class CodemirrorStyle{
	constructor(){
		this.domLoaded = this.domLoaded.bind(this);
		if (document.readyState === 'loading') {
			//Listend for change
			document.addEventListener('readystatechange', this.domLoaded )
		} else {
			this.domLoaded()
		}
	}

	domLoaded(){
		console.log("dom before remove");
		document.removeEventListener('readystatechange',this.domLoaded);
		console.log("dom after remove");
		document.querySelectorAll('.CodeMirror').forEach(this.changeClass).forEach(this.changeStyles);
	}

	changeClass(el){
		console.log("changeClass");
		el.className = el.className.replace(/cm-s-\S*/,'cm-s-gruvbox-dark');
	}
}

new CodemirrorStyle();
