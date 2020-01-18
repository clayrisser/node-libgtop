{
  'targets': [
    {
      'target_name': '<(module_name)',
      'sources': [
        'clib/main.cc'
      ],
      'conditions': [
        ['OS=="linux"',
         {
           'libraries': [
             '<!@(pkg-config --libs libgtop-2.0)'
           ],
           'ldflags': [
             '<!@(pkg-config --libs libgtop-2.0)'
           ],
           'cflags': [
             '<!@(pkg-config --cflags libgtop-2.0)',
           ]
         }
        ]
      ],
      'include_dirs': [
        '<!(node -e "require(\'nan\')")'
      ]
    },
    {
      "target_name": "action_after_build",
      "type": "none",
      "dependencies": [ "<(module_name)" ],
      'conditions': [
        ['OS=="linux"', {
          "copies": [
            {
              "files": [ "/usr/include/libgtop-2.0" ],
              "destination": "<(module_path)/lib.target/"
            },
            {
              "files": [ "/usr/include/glib-2.0" ],
              "destination": "<(module_path)/lib.target/"
            },
            {
              "files": [ "/usr/lib/x86_64-linux-gnu/glib-2.0/include" ],
              "destination": "<(module_path)/lib.target/"
            }
          ]
        }]
      ]
    }
  ]
}
