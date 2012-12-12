// Generated by CoffeeScript 1.4.0
(function(){var e,t,n,r,i=function(e,t){return function(){return e.apply(t,arguments)}};n=function(){function e(){this.handleHvSwitch=i(this.handleHvSwitch,this);this.setupHvPicker=i(this.setupHvPicker,this);this.setupHvPicker()}e.prototype.setupHvPicker=function(){var e;e=$("#hv-picker");this.current=e.find(".vertical");e.on("click","button",this.handleHvSwitch);return this.current.trigger("click")};e.prototype.handleHvSwitch=function(e){var t;e.preventDefault();t=$(e.currentTarget);if(t.hasClass("current"))return;t.siblings().removeClass("current");t.addClass("current");this.layout=t.data("layout");return $("body").trigger("optionChange")};return e}();t=function(){function e(e,t){var n=this;this.cssifier=e;this.options=t;this.updateSprite=i(this.updateSprite,this);this.addFile=i(this.addFile,this);this.files=[];this.canvas=$("<canvas>")[0];this.ctx=this.canvas.getContext("2d");this.previewImage=$("#preview-container").find("img");$("body").on("optionChange",function(){if(n.files.length){n.updateSprite();return n.cssifier.cssify(n.files)}})}e.prototype.addFile=function(e){this.files.push(e);this.updateSprite();return this.cssifier.cssify(this.files)};e.prototype.updateSprite=function(){var e,t,n,r,i,s,o,u,a,f,l,c,h,p,d,v,m;s=this.options.layout;o=0;e=0+o;l=0;u=0;f=0;a=0;s==="v"?a+=o:f+=o;this.canvas.width=this.canvas.width;v=this.files;for(c=0,p=v.length;c<p;c++){t=v[c];i=new Image;i.src=t.data;r=i.width;n=i.height;r>l&&(l=r);n>u&&(u=n);t.size={width:r,height:n};if(s==="v"){t.offset={left:0,top:a};f=l;a+=n+o}else{t.offset={left:f,top:0};f+=r+o;a=u}}this.canvas.width=f;this.canvas.height=a;s==="v"?this.previewImage.css({maxWidth:"auto",maxHeight:"100%"}):this.previewImage.css({maxWidth:"100%",maxHeight:"auto"});m=this.files;for(h=0,d=m.length;h<d;h++){t=m[h];i=new Image;i.src=t.data;r=i.width;n=i.height;s==="v"?this.ctx.drawImage(i,0,e):this.ctx.drawImage(i,e,0);e+=(s==="v"?n:r)+o}return this.previewImage.attr("src",this.canvas.toDataURL())};return e}();r=function(){function e(e){this.generator=e;this.processFile=i(this.processFile,this);this.handleDrop=i(this.handleDrop,this);this.handleDragLeave=i(this.handleDragLeave,this);this.handleDragEnter=i(this.handleDragEnter,this);this.initializeTarget=i(this.initializeTarget,this);this.initializeTarget()}e.prototype.initializeTarget=function(){this.target=$("#preview-container");this.target.on("dragenter",this.handleDragEnter);this.target.on("dragleave",this.handleDragLeave);return this.target.on("drop",this.handleDrop)};e.prototype.handleDragEnter=function(e){console.log(e);return this.target.addClass("drag-over")};e.prototype.handleDragLeave=function(e){return this.target.removeClass("drag-over")};e.prototype.handleDrop=function(e){var t,n,r,i;e.preventDefault();this.target.addClass("dropped");this.target.removeClass("drag-over");i=e.originalEvent.dataTransfer.files;for(n=0,r=i.length;n<r;n++){t=i[n];this.processFile(t)}return!1};e.prototype.processFile=function(e){var t,n=this;if(!e.type.match(/^image\/(png|jpg|jpeg|gif)$/)){alert("GIF, PNG, and JPG only.");return}t=new FileReader;t.addEventListener("load",function(t){return setTimeout(function(){return n.generator.addFile({rawName:e.name,name:e.name.substr(0,e.name.lastIndexOf(".")),data:t.target.result})},100)});return t.readAsDataURL(e)};return e}();e=function(){function e(){this.cssify=i(this.cssify,this)}e.prototype.cssify=function(e){var t,n,r,i,s;r="sprite";t="."+r+' { background: url("'+r+'.png"); }\n';for(i=0,s=e.length;i<s;i++){n=e[i];t+="."+r+"."+n.name+" { background-position: -"+n.offset.left+"px -"+n.offset.top+"px; width: "+n.size.width+"px; height: "+n.size.height+"px; }\n"}return $("#css-container").find("textarea").html(t)};return e}();$(document).ready(function(){var i,s,o,u;if(typeof window.FileReader=="undefined"){alert("Your browser doesn't have FileReader support. Now's a great time to try Chrome!");return}o=new n;i=new e;s=new t(i,o);return u=new r(s)})}).call(this);