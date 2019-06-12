defmodule BirinApi.Import.Users do
  alias BirinApi.Import.Common
  alias BirinApi.Accounts.User

  def from_csv_file(filename), do: Common.from_csv_file(filename, &map_fields/1)

  defp map_fields(%{
         "OBSNAME" => name,
         "PERMIT" => license_number,
         "INIT" => initials,
         "SUPERVISOR" => _supervisor,
         "ACTIVE" => _active
       }) do
    %User{
      name: name,
      license_number: license_number,
      initials: initials
    }
  end
end
