sequential-guid
===============

Node package for generating sequential unique identifiers based on unique guid seed. Generation guids version 1 and 4 cannot be done without node-uuid library, [thank you Broofa](https://github.com/broofa/node-uuid).

## Getting Started

Install it in your browser:

```html
<!-- Don't forget to include 'node-uuid' dependency (https://github.com/broofa/node-uuid) -->
<script src="sequid.js"></script>
```

Or in node.js:

```
npm install sequential-guid
```
```javascript
var Uid = require('sequential-guid')
```

...and create object
```javascript
  var uid = new Uid
```

Creating new instance of guid class cause generation of the seed 
```javascript
  console.log( uid.seed )   // output guid like this: 6e44dc51-804d-47ab-a933-f94641cf86cf
```

You can deffer generating seed value by seting *deferInit* property. Now new object has undefined seed until you call *next()* method on it, 
we can also specify value for seed
```javascript
  Uid.prototype.deferInit = true
  var iid = new Uid
  iid.seed = '00000000-0000-4000-a000-000000000000'
```

lets generate unique identifiers
```javascript
  console.log( uid.next() )	// '00000000-0000-4000-a000-000000000001'
  console.log( uid.next() )	// '00000000-0000-4000-a000-000000000002'
  console.log( uid.next() )	// '00000000-0000-4000-a000-000000000003'
  console.log( uid.next() )	// '00000000-0000-4000-a000-000000000004'
  console.log( uid.next() )	// '00000000-0000-4000-a000-000000000005'
```

That's all, thanks for reading :)