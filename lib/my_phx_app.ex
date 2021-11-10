defmodule MyPhxApp do
 alias  MyPhxApp.Services.ActionSonda

 defdelegate moving(params), to: ActionSonda, as: :call
end
