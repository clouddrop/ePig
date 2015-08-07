package samar.udf;

import java.io.IOException;
import org.apache.pig.FilterFunc;
import org.apache.pig.backend.executionengine.ExecException;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.DataType;
import org.apache.pig.impl.util.WrappedIOException;

public class ISADULT extends FilterFunc {
	public Boolean exec(Tuple input) throws IOException {
		if (input == null || input.size() == 0)
			return null;
		try {
			Object values = input.get(0);
			if (values == null) {
				return false;
			} else if (values instanceof Integer)

				return ((Integer) values) > 18 ? true : false;
			else {
				throw new IOException("Cannot test a " + DataType.findTypeName(values) + " for emptiness.");
			}
		} catch (ExecException ee) {
			throw WrappedIOException.wrap("Caught exception processing input row ", ee);
		}
	}
}
