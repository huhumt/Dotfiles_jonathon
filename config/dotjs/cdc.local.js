(function(){
	var previousWidth = window.innerWidth;
	var menuState = "unset";
	var nav;

	/**
	 * keyboardInteract
	 *
	 * controlls the keyboard interaction on the menu.
	 *
	 * @param a <element>: The anchor element that has focus
	 * @param interaction <string>: The type of interaction left/right/up/down/tab etc.
	 * @param e <event>: The event (so we can prevent default etc)
	 * @param loc <string>: The location of the anchor that has focus top/inner
	 **/

	function keyboardInteract(a,interaction,e, loc){
		if (loc == "top"){ //If focus is on one of the top row
			switch (interaction){
				case "up": //I don't think this should ever be needed but close the submenu
					closeChildMenu(a.parentElement);
					e.preventDefault();
					e.stopPropagation();
					break;
				case "down": //Open the sub menu
					openChildMenu(a.parentElement);
					e.preventDefault();
					e.stopPropagation();
					break;
				case "left": //Move to the left (or last if at first)
					var previousLi = a.parentElement.previousElementSibling;
					if(previousLi == null){
						var children = a.parentElement.parentElement.children;
						previousLi = children[children.length - 1];
					}
					previousLi.querySelector("a").focus();
					e.preventDefault();
					e.stopPropagation();
					break;
				case "right": //Move to the right or first if on last
					var nextLi = a.parentElement.nextElementSibling;
					if(nextLi == null){
						nextLi = a.parentElement.parentElement.querySelector("li"); //This is the first li
					}
					nextLi.querySelector("a").focus();
					e.preventDefault();
					e.stopPropagation();
					break;
			}
		} else if (loc == "second"){
			switch (interaction){
				case "esc":
				case "up":
					var containerLi = a.parentElement.parentElement.parentElement;
					if(containerLi.tagName.toUpperCase() == "ul"){ //This section is for the 2 row Health and Safety catagory
						containerLi = containerLi.parentElement;
					}
					closeChildMenu(containerLi);
					e.preventDefault();
					e.stopPropagation();
					break;
				case "right":
					var nextLi = a.parentElement.nextElementSibling;
					if(nextLi == null){ //If on last li, go to first
						nextLi = a.parentElement.parentElement.children[0];
					}
					while(nextLi.querySelector("a")==null){
						nextLi = nextLi.nextElementSibling;
						if(nextLi == null){ //If on last li, go to first
							nextLi = nextLi.parentElement.children[0];
						}
					}
					nextLi.querySelector("a").focus();
					e.preventDefault();
					e.stopPropagation();
					break;
				case "left":
					var nextLi = a.parentElement.previousElementSibling;
					if(nextLi == null){ //If on last li, go to first
						nextLi = a.parentElement.parentElement.children[a.parentElement.parentElement.children.length -1];
					}
					while(nextLi.querySelector("a")==null){
						nextLi = nextLi.previoudElementSibling;
						if(nextLi == null){ //If on last li, go to first
							nextLi = nextLi.parentElement.children[nextLi.parentElement.children.length - 1];
						}
					}
					nextLi.querySelector("a").focus();
					e.preventDefault();
					e.stopPropagation();
					break;
				case "down":
					//If it has third level anchors under it
						//Focus on child nav
					//Else if it has a second row of sub-cats
						//If there is one directly beneith current focus, focus on it
						//Else focus the last in the row below
					//Else dont do anything
					e.preventDefault();
					e.stopPropagation();
					break;
				case "up":
					//If on the second row, go to the first row
						//If the element above in the first row has sub-sub-cats, focus the last of them
						//Otherwise focus on the sub-cat directly benieth
					//If on the first row close the submenu
			}
		}
	}
	/**
	 * setupKeyboardEventListeners
	 *
	 * Sets up the event listenrs for an array like object of elements (normally anchors or buttons)
	 *
	 * els <array|nodelist>: The list of elements
	 * position <string>: The position string to be passed to the new function
	 **/
	function setupKeyboardEventListeners(els, position){
		els.forEach(function(a,i,list){
			var self = a;
			a.fpEvent=function(e){
				var keyCode = e.keyCode;
				switch (keyCode) {
					case 38: // Up arrow
					case 75: // K key
						keyboardInteract(self,"up",e,position);
						break;
					case 40: // Down arrow
					case 74: // J Key
						keyboardInteract(self,"down",e,position);
						break;
					case 37: // Left arrow
					case 72: // H Key
						keyboardInteract(self,"left",e,position);
						break;
					case 39: // Right arrow
					case 76: // L Key
						keyboardInteract(self,"right",e,position);
						break;
					case 9: // Tab Key
						keyboardInteract(self,"tab",e,position);
						break;
					case 27: // ESC Key
						keyboardInteract(self,"esc",e,position);
						break;
				}
			}
			a.addEventListener("keydown", a.fpEvent);
		});
	}
	function openChildMenu(li){
		li.classList.add("open"); //Display the menu
		console.log(li);
		console.log(li.querySelector("ul").querySelector("a"));
		li.querySelector("ul").querySelector("a").focus(); //Focus on the first anchor
	}
	function closeChildMenu(li){
		li.classList.remove("open");
		li.querySelector("a").focus();
	}

	function unsetMobile(){
		console.log("unsetMobile");
	}
	function unsetDesktop(){
		console.log("unsetDesktop");
	}
	function setupMobile(){
		console.log("setupMobile");
	}
	function setupDesktop(){
		console.log("setupDesktop");
		var topLevel = nav.querySelectorAll("nav>ul>li>a");
		var secondLevel = nav.querySelectorAll("nav>ul .heading");
		var thirdLevel = nav.querySelectorAll("nav>ul ul ul a");
		setupKeyboardEventListeners(topLevel, "top");
		setupKeyboardEventListeners(secondLevel, "second");
		setupKeyboardEventListeners(thirdLevel, "third");
	}
	function doMenu(){
		//If mobile
		if (window.matchMedia("(min-width: 800px)").matches){// If desktop width
			if(menuState == "mobile"){ // If currently mobile
				unsetMobile();
				setupDesktop();
				menuState = "desktop";
			}
			if(menuState == "unset"){ // If currently unset
				setupDesktop();
				menuState = "desktop";
			}
		} else { //If mobile width
			if(menuState == "desktop"){ // If currently desktop
				//Switch to mobile
				unsetDesktop();
				setupMobile();
				menuState = "mobile";
			}
			if(menuState == "unset"){ // If currently unset
				setupMobile();
				menuState = "mobile";
			}
		}
	}
	window.addEventListener("load",function(){
		nav = document.querySelector("#menu-wrapper");
		doMenu();
	});
	window.addEventListener("resize",function(e){
		//If width has changed
		if (previousWidth != window.innerWidth){
			previousWidth = window.innerWidth;
			console.log("Changing width");
			doMenu();
		}
	});
})();

