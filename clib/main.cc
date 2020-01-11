#include <glibtop/proclist.h>
#include <nan.h>
#include <v8.h>

glibtop_proclist proclist;

void Count(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  pid_t* pids;
  pids = glibtop_get_proclist(&proclist, 0, 1);
  info.GetReturnValue().Set(Nan::New<v8::Number>(proclist.number));
  g_free(pids);
}

void List(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  pid_t* pids;
  v8::Local<v8::Array> v8Pids = Nan::New<v8::Array>();
  pids = glibtop_get_proclist(&proclist, 0, 1);
  for (unsigned int i = 0; i < proclist.number; i++) {
    v8Pids->Set(i, Nan::New<v8::Number>(pids[i]));
  }
  info.GetReturnValue().Set(v8Pids);
  g_free(pids);
}

void Init(v8::Local<v8::Object> exports) {
  v8::Local<v8::Context> context = exports->CreationContext();
  exports->Set(context,
               Nan::New("count").ToLocalChecked(),
               Nan::New<v8::FunctionTemplate>(Count)->GetFunction(context).ToLocalChecked());
  exports->Set(context,
               Nan::New("list").ToLocalChecked(),
               Nan::New<v8::FunctionTemplate>(List)->GetFunction(context).ToLocalChecked());
}

NODE_MODULE(node_ps_sync, Init)
